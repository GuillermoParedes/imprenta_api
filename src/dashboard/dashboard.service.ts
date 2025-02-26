import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { ProductsService } from 'src/products/products.service';

@Injectable()
export class DashboardService extends PrismaService {



  async stockProducts() {

    const categories = await this.category.findMany({
      select: {
        id: true,
        name: true,
      },
    });

    const countsByCategory = await this.product.groupBy({
      by: ['categoryId'],
      _count: {
        id: true,
      },
    });
    const categoryMap = new Map(categories.map(c => [c.id, c.name]));
    const chartData = categories.map(category => ({
      name: category.name,
      count: countsByCategory.find(c => c.categoryId === category.id)?._count.id || 0
    }));

    return chartData
  }

  async topSells() {
    const categories = await this.category.findMany({
      select: {
        id: true,
        name: true,
      },
    });
    const ordersByDateAndCategory = await this.order.findMany({
      where: {
        status: 'ENTREGADO',
      },
      select: {
        totalAmount: true,
        dateShipping: true,
        product: {
          select: {
            categoryId: true,
          },
        },
      },
    });
    // Crear un mapa para almacenar los datos por categoría y fecha
    const categoryDataMap = new Map<string, Map<string, number>>();

    ordersByDateAndCategory.forEach(order => {
      const categoryId = order.product.categoryId;
      const date = order.dateShipping.toISOString().split('T')[0]; // Formato YYYY-MM-DD

      if (!categoryDataMap.has(categoryId)) {
        categoryDataMap.set(categoryId, new Map());
      }

      const dateMap = categoryDataMap.get(categoryId)!;
      dateMap.set(date, (dateMap.get(date) || 0) + order.totalAmount);
    });

    // Obtener todas las fechas únicas en orden cronológico
    const allDates = Array.from(
      new Set(ordersByDateAndCategory.map(o => o.dateShipping.toISOString().split('T')[0]))
    ).sort();

    // Formatear los datos para el gráfico
    const series = categories.map(category => {
      const data = allDates.map(date => categoryDataMap.get(category.id)?.get(date) || 0);
      return {
        name: `${category.name}`,
        data,
      };
    });

    return {
      series,
      chart: {
        type: 'bar',
        height: 350,
      },
      xaxis: {
        categories: allDates,
      },
      colors: ['#1E88E5', '#FF5733', '#FFC300', '#4CAF50', '#9C27B0'], // Puedes personalizar los colores
    };
  }

}
