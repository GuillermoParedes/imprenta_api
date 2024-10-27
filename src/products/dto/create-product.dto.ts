import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber, IsString } from "class-validator";

export class CreateProductDto {

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  description: string;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty()
  sellingPrice: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty()
  actualPrice: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty()
  stock: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  categoryId: string;

}
