import { ApiProperty } from '@nestjs/swagger';
import { Order, OrderStatus } from '@prisma/client';

export class OrderEntity implements Order {
  constructor(partial: Partial<OrderEntity>) {
    Object.assign(this, partial);
  }

  @ApiProperty({ description: 'ID único de la orden' })
  id: string;

  @ApiProperty({ description: 'ID del cliente asociado' })
  customerId: string;

  @ApiProperty({ description: 'ID del producto asociado' })
  productId: string;

  @ApiProperty({ description: 'Costo total de la orden' })
  totalAmount: number;

  @ApiProperty({ description: 'Adelanto de la orden' })
  advancePayment: number;

  @ApiProperty({ description: 'Cantidad de la orden' })
  quantity: number;

  @ApiProperty({ description: 'Fecha de envío de la orden' })
  dateShipping: Date;

  @ApiProperty({ description: 'Fecha de creación de la orden' })
  createdAt: Date;

  @ApiProperty({ description: 'Fecha de última actualización de la orden' })
  updatedAt: Date;

  @ApiProperty({ description: 'Estado actual de la orden', enum: OrderStatus })
  status: OrderStatus;
}
