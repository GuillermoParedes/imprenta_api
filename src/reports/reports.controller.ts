import { Controller, Get, Res, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { CreateReportDto } from './dto/create-report.dto';
import { UpdateReportDto } from './dto/update-report.dto';
import { Response } from 'express';

@Controller('reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}



  // @Get()
  // generatePdf(@Res() res: Response) {
  //   this.reportsService.generatePdf(res);
  // }

  @Get('download') // Usa 'download' para evitar conflictos con otra ruta
  generatePdf(@Res() res: Response) {
    return this.reportsService.generatePdf(res);
  }
}
