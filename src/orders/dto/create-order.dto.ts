import { ApiProperty } from "@nestjs/swagger";
import { IsDate, IsEnum, IsNotEmpty, IsNumber, IsOptional, IsString } from "class-validator";
import { OrderStatus } from "@prisma/client";

export class CreateOrderDto {

  @IsString()
  @IsNotEmpty()
  @ApiProperty({ description: 'ID del cliente asociado a la orden' })
  customerId: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({ description: 'ID del producto asociado a la orden' })
  productId: string;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({ description: 'Costo total de la orden' })
  totalAmount: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({ description: 'Adelanto del producto' })
  advancePayment: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({ description: 'Cantidad del producto' })
  quantity: number;

  @IsNotEmpty()
  @ApiProperty({ description: 'Fecha de envío de la orden' })
  dateShipping: Date;

  @IsEnum(OrderStatus)
  @IsOptional()
  @ApiProperty({ description: 'Estado actual de la orden', enum: OrderStatus })
  status: OrderStatus;
}
