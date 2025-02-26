import { Injectable } from '@nestjs/common';
import * as PDFDocument from 'pdfkit';
import { Response } from 'express';
import * as path from 'path';

@Injectable()
export class ReportsService {

  generatePdf(reportTitle, tableData, res: Response) {
    console.log('🔹 Generando PDF...'); // Ver si realmente entra aquí

    const doc = new PDFDocument({ size: 'A4', margin: 50 });

    // Enviar como respuesta HTTP
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename="reporte.pdf"');

    doc.pipe(res);

    // **1. Encabezado**
    this.addHeader(doc, reportTitle);

    // **2. Contenido: Tabla de datos**
    this.addTable(doc, tableData);

    // **3. Pie de página**
    this.addFooter(doc);

    // Finalizar el PDF
    doc.end();

    console.log('✅ PDF generado con éxito');
  }
  private addHeader(doc: PDFDocument, title: string) {
    const imagePath = path.resolve(__dirname, '../../assets/logo_horizontal.png');
    // Agregar logo (reemplaza 'logo.png' con la ruta de tu logo)
    doc.image(imagePath, 50, 30, { width: 100 });

    // Título centrado
    doc
      .fontSize(20)
      .font('Helvetica-Bold')
      .text(title, 0, 50, { align: 'center' });

    doc.moveDown();
  }
  private addTable(doc: PDFDocument, tableData: any[]) {
    const startY = 100;
    const startX = 50;
    const columnWidths = [200, 150, 100]; // Ancho de columnas

    // Dibujar encabezados de la tabla
    doc
      .font('Helvetica-Bold')
      .fontSize(12)
      .text('Nombre', startX, startY, { width: columnWidths[0] })
      .text('Descripción', startX + columnWidths[0], startY, { width: columnWidths[1] })
      .text('Cantidad', startX + columnWidths[0] + columnWidths[1], startY, { width: columnWidths[2] });

    doc.moveDown();

    // Dibujar filas de la tabla
    let y = startY + 20;
    doc.font('Helvetica').fontSize(10);

    tableData.forEach((row) => {
      doc
        .text(row.name, startX, y, { width: columnWidths[0] })
        .text(row.description, startX + columnWidths[0], y, { width: columnWidths[1] })
        .text(row.quantity.toString(), startX + columnWidths[0] + columnWidths[1], y, { width: columnWidths[2] });

      y += 20;
    });

    doc.moveDown();
  }
  private addFooter(doc: PDFDocument) {
    const now = new Date();
    const formattedDate = now.toLocaleString('es-ES');

    doc
      .fontSize(10)
      .text(`Generado el: ${formattedDate}`, 50, 750, { align: 'right' });
  }
}
