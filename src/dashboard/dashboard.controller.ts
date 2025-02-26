import { Controller, Get } from '@nestjs/common';
import { DashboardService } from './dashboard.service';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';

@Controller('dashboard')
export class DashboardController {
  todoService: any;
  constructor(private readonly dashboardService: DashboardService) { }


  @Get('stock-products')
  findAll() {
    return this.dashboardService.stockProducts();
  }

  @Get('top-sells')
  getTopSells() {
    return this.dashboardService.topSells();
  }

}
