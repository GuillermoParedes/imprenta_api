import { Injectable } from '@nestjs/common';
import * as PDFDocument from 'pdfkit';
import { Response } from 'express';
import * as path from 'path';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ReportsService extends PrismaService {
  async getRevenue(res: Response, params: any) {
    const pedidosEntregados = await this.order.findMany({
      where: {
        status: 'ENTREGADO',
        dateShipping: {
          gte: params.startDate ? new Date(new Date(params.startDate).setUTCHours(0, 0, 0, 0)) : undefined,
          lte: params.endDate ? new Date(new Date(params.endDate).setUTCHours(23, 59, 59, 999)) : undefined
        }
      },
      orderBy: {
        dateShipping: 'desc'
      }
    })
    const pedidosPendientes = await this.order.findMany({
      where: {
        status: 'PENDIENTE',
        dateShipping: {
          gte: params.startDate ? new Date(new Date(params.startDate).setUTCHours(0, 0, 0, 0)) : undefined,
          lte: params.endDate ? new Date(new Date(params.endDate).setUTCHours(23, 59, 59, 999)) : undefined
        }
      },
      orderBy: {
        dateShipping: 'desc'
      }
    })
    console.log('GENERADO REPORTE DIARIO')
    // Totales
    const totalEntregado = pedidosEntregados.reduce((acc, p) => acc + Number(p.totalAmount || 0), 0);
    const totalPendiente = pedidosPendientes.reduce((acc, p) => acc + Number(p.advancePayment || 0), 0);

    const doc = new PDFDocument();

    // Enviar como descarga
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', `attachment; filename="reporte-pedidos.pdf"`);

    doc.pipe(res);

    doc.fontSize(20).text('Reporte de Ingresos', { align: 'center' });
    doc.moveDown();

    if (params.startDate && params.endDate) {
      doc.fontSize(12).text(`Rango de fechas: ${params.startDate || '---'} al ${params.endDate || '---'}`);
      doc.moveDown();
    } else if (params.startDate) {
      doc.fontSize(12).text(`Hasta la fecha: ${params.startDate}`);
      doc.moveDown();
    } else if (params.endDate) {
      doc.fontSize(12).text(`Hasta la fecha: ${params.endDate}`);
      doc.moveDown();
    }


    doc.fontSize(14).fillColor('green').text(`Entregados`, { underline: true });
    doc.fillColor('black').text(`- Cantidad: ${pedidosEntregados.length}`);
    doc.text(`- Total: Bs. ${totalEntregado.toFixed(2)}`);
    doc.moveDown();

    doc.fontSize(14).fillColor('red').text(`Pendientes`, { underline: true });
    doc.fillColor('black').text(`- Cantidad: ${pedidosPendientes.length}`);
    doc.text(`- Total: Bs. ${totalPendiente.toFixed(2)}`);
    doc.moveDown();

    doc.fontSize(10).fillColor('gray').text(`Generado el: ${new Date().toLocaleString()}`);

    doc.end();

  }
  async getOrders(res: Response, params: any) {
    const pedidos = await this.order.findMany({
      where: {
        status: params.status,
        dateShipping: {
          gte: params.startDate ? new Date(new Date(params.startDate).setUTCHours(0, 0, 0, 0)) : undefined,
          lte: params.endDate ? new Date(new Date(params.endDate).setUTCHours(23, 59, 59, 999)) : undefined
        }
      },
      include: {
        customer: true,
        product: true,
      },
      orderBy: {
        dateShipping: 'desc'
      }
    })

    const chartData = pedidos.map(item => {
      return {
        ...item,
        productName: item.product.name
      }
    })
    const title = 'Pedidos';
    const columns = [
      { title: 'Fecha de entrega', key: 'dateShipping', width: 150 },
      { title: 'Nombre del Producto', key: 'productName', width: 150 },
      { title: 'Cantidad del producto', key: 'quantity', width: 100 },
      { title: 'Costo totaal', key: 'totalAmount', width: 100 },
    ];
    return this.generatePdf(title, chartData, columns, res);

  }

  async getStockProducts(res: Response, params: any) {
    const categories = await this.category.findMany({
      select: {
        id: true,
        name: true,
      },
    });

    const productsByCategory = await this.product.findMany({
      where: {
        createdAt: {
          gte: params.startDate ? new Date(new Date(params.startDate).setUTCHours(0, 0, 0, 0)) : undefined,
          lte: params.endDate ? new Date(new Date(params.endDate).setUTCHours(23, 59, 59, 999)) : undefined
        }
      },
      orderBy: {
        name: 'asc'
      }
    });
    const chartData = productsByCategory.map(product => ({
      category: categories.find(c => c.id === product.categoryId)?.name || 'Desconocido',
      productName: product.name,
      count: product.stock,
    }));
    const title = 'Stock de Productos';
    const columns = [
      { title: 'Tipo de Producto', key: 'category', width: 150 },
      { title: 'Nombre del Producto', key: 'productName', width: 150 },
      { title: 'Cantidad Disponible', key: 'count', width: 100 },
    ];
    return this.generatePdf(title, chartData, columns, res);
  }
  async getSummaryClientsJuridica(res: Response, params: any) {
    const clients = await this.client.findMany({
      where: {
        type: 'JURIDICA',
        createdAt: {
          gte: params.startDate ? new Date(new Date(params.startDate).setUTCHours(0, 0, 0, 0)) : undefined,
          lte: params.endDate ? new Date(new Date(params.endDate).setUTCHours(23, 59, 59, 999)) : undefined
        }
      },
      orderBy: { createdAt: 'desc' },
    });

    const title = 'Resumen de Clientes Juridicos';
    const columns = [
      { title: 'Nombre de empresa', key: 'first_name', width: 250 },
      { title: 'Celular', key: 'cellphone', width: 150 },
    ];

    return this.generatePdf(title, clients, columns, res);
  }

  async getSummaryClientsNatural(res: Response, params: any) {
    const clients = await this.client.findMany({
      where: {
        type: 'NATURAL',
        createdAt: {
          gte: params.startDate ? new Date(new Date(params.startDate).setUTCHours(0, 0, 0, 0)) : undefined,
          lte: params.endDate ? new Date(new Date(params.endDate).setUTCHours(23, 59, 59, 999)) : undefined
        }
      },
      orderBy: { createdAt: 'desc' },
    });

    const title = 'Resumen de Clientes Naturales';
    const columns = [
      { title: 'Nombre', key: 'first_name', width: 150 },
      { title: 'Apellido', key: 'last_name', width: 150 },
      { title: 'Celular', key: 'cellphone', width: 100 },
    ];

    return this.generatePdf(title, clients, columns, res);
  }

  generatePdf(reportTitle: string, tableData: any[], columns: any[], res: Response) {
    console.log('🔹 Generando PDF...');

    const doc = new PDFDocument({ size: 'Legal', margin: 50 });
    const formattedTitle = reportTitle.replace(/\s+/g, '_'); // Reemplazar espacios por _
    const formattedDate = new Date().toISOString().split('T')[0]; // Obtener fecha YYYY-MM-DD
    const fileName = `${formattedTitle}_${formattedDate}.pdf`;
    // Configuración de respuesta HTTP
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', `attachment; filename="${fileName}"`);


    doc.pipe(res);

    // Agregar encabezado
    this.addHeader(doc, reportTitle);

    // Agregar tabla con mejor manejo de espacio
    this.addTable(doc, tableData, columns);

    // Agregar pie de página
    this.addFooter(doc);

    doc.end();
    console.log('✅ PDF generado con éxito');
  }

  private addHeader(doc: PDFDocument, title: string) {
    const imagePath = path.resolve(__dirname, '../../assets/logo_horizontal.png');

    // Agregar logo
    doc.image(imagePath, 50, 30, { width: 100 });

    // Título centrado con margen
    doc
      .fillColor('#333')
      .fontSize(20)
      .font('Helvetica-Bold')
      .text(title, 0, 70, { align: 'center' });

    doc.moveDown(2);
  }

  private addTable(doc: PDFDocument, tableData: any[], columns: any[]) {
    let startX = 50;
    let startY = 120;
    const rowHeight = 40;
    const pageHeight = 750; // Altura total utilizable

    // Dibujar encabezados con fondo azul
    doc
      .font('Helvetica-Bold')
      .fontSize(12)
      .fillColor('white')
      .rect(startX, startY, columns.reduce((sum, col) => sum + col.width, 0), rowHeight)
      .fill('#0073e6')
      .stroke();

    let x = startX;
    columns.forEach((col) => {
      doc
        .fillColor('white')
        .text(col.title, x + 5, startY + 8, { width: col.width, align: 'center' });
      x += col.width;
    });

    doc.fillColor('#333').font('Helvetica').fontSize(10);

    let y = startY + rowHeight;

    // **Dibujar filas con verificación de salto de página**
    tableData.forEach((row, index) => {
      if (y + rowHeight > pageHeight) {
        doc.addPage(); // Nueva página
        y = 50; // Reset de altura
      }

      if (index % 2 === 0) {
        doc
          .rect(startX, y, columns.reduce((sum, col) => sum + col.width, 0), rowHeight)
          .fill('#f0f0f0')
          .stroke();
      }

      let x = startX;
      columns.forEach((col) => {
        doc
          .fillColor('#333')
          .text(row[col.key] || '-', x + 5, y + 8, {
            width: col.width,
            align: 'center',
          });
        x += col.width;
      });

      y += rowHeight;
    });

    doc.moveDown();
  }

  private addFooter(doc: PDFDocument) {
    const now = new Date();
    const formattedDate = now.toLocaleString('es-ES');

    doc
      .moveTo(50, 750)
      .lineTo(550, 750)
      .strokeColor('#0073e6')
      .stroke();

    doc
      .fillColor('#333')
      .fontSize(10)
      .text(`Generado el: ${formattedDate}`, 50, 760, { align: 'right' });
  }
}
