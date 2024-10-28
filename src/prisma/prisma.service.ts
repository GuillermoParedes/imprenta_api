import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient, Prisma } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  constructor() {
    super({
      log: ['query', 'info', 'warn', 'error'], // Habilita logging de Prisma
    });
  }

  async onModuleInit() {
    // Conectar Prisma
    await this.$connect();
    this.addMiddlewares(); // Llama a los middlewares después de conectar
  }

  async onModuleDestroy() {
    // Desconectar Prisma al destruir el módulo
    await this.$disconnect();
  }

  private addMiddlewares() {
    // Middleware de ejemplo para loggear todas las consultas
    this.$use(async (params, next) => {
      console.log(`Executing query: ${params.model}.${params.action}`);
      console.log(`Query params: ${JSON.stringify(params.args)}`);
      const result = await next(params);
      console.log(`Query result: ${JSON.stringify(result)}`);
      return result;
    });
  }
}
