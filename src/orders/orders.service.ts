import { Injectable } from '@nestjs/common';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class OrdersService {

  constructor(private prisma: PrismaService) { }


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
      return {
        message: 'Pedido creado correctamente',
        pedido: data
      };
    } catch (error) {
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
}
