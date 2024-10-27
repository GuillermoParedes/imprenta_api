import { Injectable } from '@nestjs/common';
import { CreateClientDto } from './dto/create-client.dto';
import { UpdateClientDto } from './dto/update-client.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ClientsService {

  constructor(private prisma: PrismaService) { }

  async create(createClientDto: CreateClientDto) {
    try {
      const data = await this.prisma.client.create({
        data: createClientDto
      })
      return {
        message: 'Cliente creado correctamente',
        cliente: data
      };
    } catch (error) {
      return {
        message: 'Ocurrio un problema',
        error: error
      }
    }

  }

  findAll() {
    return this.prisma.client.findMany();
  }

  findOne(id: string) {
    return this.prisma.client.findFirst({
      where: {
        id
      }
    });
  }

  async update(id: string, updateClientDto: UpdateClientDto) {
    try {
      const data = await this.prisma.client.update({
        where: {
          id
        },
        data: {
          ...updateClientDto
        }
      })
      return {
        message: 'Cliente actualizado correctamente',
        cliente: data
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
      const data = await this.prisma.client.delete({
        where: {
          id
        }
      })
      return {
        message: 'Cliente eliminado correctamente',
        cliente: data
      };
    } catch (error) {
      return {
        message: 'Ocurrio un problema',
        error: error
      }
    }

  }
}
