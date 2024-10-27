import { Injectable } from '@nestjs/common';
import { CreateClientDto } from './dto/create-client.dto';
import { UpdateClientDto } from './dto/update-client.dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class ClientsService {

  constructor(private prisma: PrismaService) { }

  async create(createClientDto: CreateClientDto) {
    console.log('create', createClientDto)
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

  findOne(id: number) {
    return `This action returns a #${id} client`;
  }

  update(id: number, updateClientDto: UpdateClientDto) {
    return `This action updates a #${id} client`;
  }

  remove(id: number) {
    return `This action removes a #${id} client`;
  }
}
