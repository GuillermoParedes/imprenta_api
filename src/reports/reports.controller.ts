import { Controller, Get, Res, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { CreateReportDto } from './dto/create-report.dto';
import { UpdateReportDto } from './dto/update-report.dto';
import { Response } from 'express';

@Controller('reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) { }

  @Get('summary-clients-natural')
  getSummaryClientsNatural(@Res() res: Response) {
    return this.reportsService.getSummaryClientsNatural(res);
  }
  @Get('summary-clients-juridica')
  getSummaryClientsJuridica(@Res() res: Response) {
    return this.reportsService.getSummaryClientsJuridica(res);
  }
  @Get('stock-products')
  getStockProducts(@Res() res: Response) {
    return this.reportsService.getStockProducts(res);
  }

}
