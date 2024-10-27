import { ApiProperty } from "@nestjs/swagger";
import { ClientRanking, ClientType, Order } from "@prisma/client";
import { IsNotEmpty, IsOptional, IsString } from "class-validator";

export class CreateClientDto {

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  first_name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  last_name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  type: ClientType

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  address: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  cellphone: string;

  @IsString()
  @IsOptional()
  @ApiProperty()
  ranking?: ClientRanking;

}
