import {
  Controller,
  Get,
  Res,
  Query,
  Logger,
} from '@nestjs/common';
import { ReportsService } from './reports.service';
import { Response } from 'express';

@Controller('reports')
export class ReportsController {
  logger = new Logger(ReportsController.name);
  constructor(private readonly reportsService: ReportsService) {}

  @Get('summary-clients-natural')
  getSummaryClientsNatural(
    @Res() res: Response,
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getSummaryClientsNatural(res, {
      startDate,
      endDate,
    });
  }
  @Get('summary-clients-juridica')
  getSummaryClientsJuridica(@Res() res: Response,
  @Query('startDate') startDate: string,
  @Query('endDate') endDate: string,) {
    return this.reportsService.getSummaryClientsJuridica(res, {
      startDate,
      endDate,
    });
  }
  @Get('stock-products')
  getStockProducts(@Res() res: Response,
  @Query('startDate') startDate: string,
  @Query('endDate') endDate: string,) {
    return this.reportsService.getStockProducts(res, { startDate, endDate });
  }

  @Get('orders')
  getOrders(@Res() res: Response,
  @Query('status') status: string,
  @Query('startDate') startDate: string,
  @Query('endDate') endDate: string) {
    return this.reportsService.getOrders(res, {startDate, endDate, status});
  }

}
