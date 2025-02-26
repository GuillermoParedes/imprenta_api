import { Injectable } from '@nestjs/common';
import * as PDFDocument from 'pdfkit';
import { Response } from 'express';
import { CreateReportDto } from './dto/create-report.dto';
import { UpdateReportDto } from './dto/update-report.dto';

@Injectable()
export class ReportsService {

  generatePdf(res: Response) {
    console.log('🔹 Generando PDF...'); // Ver si realmente entra aquí

    const doc = new PDFDocument();

    // Configurar encabezados para la descarga
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename=document.pdf');

    // Conectar el PDF con la respuesta
    doc.pipe(res);

    // Agregar contenido al PDF
    doc.fontSize(20).text('¡Hola desde NestJS!', { align: 'center' });

    // Finalizar la escritura del PDF
    doc.end();

    console.log('✅ PDF generado con éxito');
  }
}
