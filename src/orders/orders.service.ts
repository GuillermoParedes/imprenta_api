import { Injectable, Logger } from '@nestjs/common';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class OrdersService {
  logger = new Logger(OrdersService.name)
  constructor(private prisma: PrismaService) { }

  async updateStock(productId: string, newStock: number) {
    const _product = await this.prisma.product.findFirst({
      where: {
        id: productId,
      },
    })
    return this.prisma.product.update({
      where: {
        id: productId,
      },
      data: {
        stock: _product.stock - newStock
      }
    })
  }
  async create(createOrderDto: CreateOrderDto) {
    try {
      console.log('create', createOrderDto)
      const data = await this.prisma.order.create({
        data: {
          ...createOrderDto,
          dateShipping: new Date(createOrderDto.dateShipping),
          status: 'PENDIENTE'
        }
      })
      this.updateStock(createOrderDto.productId, createOrderDto.quantity)
      return {
        message: 'Pedido creado correctamente',
        pedido: data
      };
    } catch (error) {
      console.log("error", error)
      return {
        message: 'Ocurrio un problema',
        error: error
      }
    }
  }

  findAll() {
    return this.prisma.order.findMany({
      include: {
        customer: true,
        product: true
      }
    });
  }

  findOne(id: string) {
    return this.prisma.order.findFirst({
      where: {
        id
      }
    });
  }

  async update(id: string, updateOrderDto: UpdateOrderDto) {
    try {
      const data = await this.prisma.order.update({
        where: {
          id
        },
        data: {
          ...updateOrderDto
        }
      })
      return {
        message: 'Pedido actualizado correctamente',
        pedido: data
      };
    } catch (error) {
      return {
        message: 'Ocurrio un problema',
        error: error
      }
    }
  }

  async remove(id: string) {
    try {
      const data = await this.prisma.order.delete({
        where: {
          id
        }
      })
      return {
        message: 'Pedido eliminado correctamente',
        pedido: data
      };
    } catch (error) {
      return {
        message: 'Ocurrio un problema',
        error: error
      }
    }
  }

  async getRevenueByDay() {
    const today = {
      gte: new Date(new Date().setUTCHours(0, 0, 0, 0)),
      lte: new Date(new Date().setUTCHours(23, 59, 59, 999))
    }
    const revenuesEntregados = await this.prisma.order.findMany({
      where: {
        status: 'ENTREGADO',
        dateShipping: {
          lte: today.lte
        }
      },
      orderBy: {
        dateShipping: 'asc'
      }
    })
    const revenuesPendientes = await this.prisma.order.findMany({
      where: {
        status: 'PENDIENTE',
        dateShipping: {
          lte: today.lte
        }
      },
      orderBy: {
        dateShipping: 'asc'
      }
    })
    const revenuesEntregadosToday = await this.prisma.order.findMany({
      where: {
        status: 'ENTREGADO',
        dateShipping: {
          ...today
        }
      },
      orderBy: {
        dateShipping: 'asc'
      }
    })
    const revenuesPendientesToday = await this.prisma.order.findMany({
      where: {
        status: 'PENDIENTE',
        dateShipping: {
          ...today
        }
      },
      orderBy: {
        dateShipping: 'asc'
      }
    })
    const totalEntregados = revenuesEntregados.reduce((prev, curr) => {

      prev = prev + curr.totalAmount
      return prev
    }, 0)
    return {
      untilToday: {
        done: {
          count: revenuesEntregados.length,
          money: totalEntregados
        },
        pending: {
          count: revenuesPendientes.length,
          money: revenuesPendientes.reduce((prev, curr) => {
            prev = prev + curr.advancePayment
            return prev
          }, 0)
        }
      },
      today: {
        done: {
          count: revenuesEntregadosToday.length,
          money: revenuesEntregadosToday.reduce((prev, curr) => {
            prev = prev + curr.totalAmount
            return prev
          }, 0)
        },
        pending: {
          count: revenuesPendientesToday.length,
          money: revenuesPendientesToday.reduce((prev, curr) => {
            prev = prev + curr.advancePayment
            return prev
          }, 0)
        }
      }
    }
  }

}
