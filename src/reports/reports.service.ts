import { Injectable } from '@nestjs/common';
import * as PDFDocument from 'pdfkit';
import { Response } from 'express';
import * as path from 'path';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ReportsService extends PrismaService {
  async getStockProducts(res: Response) {
    const categories = await this.category.findMany({
      select: {
        id: true,
        name: true,
      },
    });

    const productsByCategory = await this.product.findMany({
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
  async getSummaryClientsJuridica(res: Response) {
    const clients = await this.client.findMany({
      where: {
        type: 'JURIDICA'
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

  async getSummaryClientsNatural(res: Response) {
    const clients = await this.client.findMany({
      where: {
        type: 'NATURAL'
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
