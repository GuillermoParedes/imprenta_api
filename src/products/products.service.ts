import { Injectable } from '@nestjs/common';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ProductsService {

  constructor(private prisma: PrismaService) { }

  async create(createProductDto: CreateProductDto) {
    try {
      console.log('create', createProductDto)
      const data = await this.prisma.product.create({
        data: createProductDto
      })
      return {
        message: 'Producto creado correctamente',
        producto: data
      };
    } catch (error) {
      return {
        message: 'Ocurrio un problema',
        error: error
      }
    }

  }

  findAll() {
    return this.prisma.product.findMany();
  }

  findOne(id: string) {
    return this.prisma.product.findFirst({
      where: {
        id
      }
    });
  }

  async update(id: string, updateProductDto: UpdateProductDto) {
    try {
      const data = await this.prisma.product.update({
        where: {
          id
        },
        data: {
          ...updateProductDto
        }
      })
      return {
        message: 'Product actualizado correctamente',
        producto: data
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
      const data = await this.prisma.product.delete({
        where: {
          id
        }
      })
      return {
        message: 'Producto eliminado correctamente',
        producto: data
      };
    } catch (error) {
      return {
        message: 'Ocurrio un problema',
        error: error
      }
    }
  }
}
