// src/users/dto/create-user.dto.ts
import { ApiProperty } from '@nestjs/swagger';
import { UserRole } from '@prisma/client';
import { IsNotEmpty, IsString, MinLength } from 'class-validator';

export class CreateUserDto {
  
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
  username: string;


  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  role: UserRole;


  @IsString()
  @IsNotEmpty()
  @MinLength(6)
  @ApiProperty()
  password: string;
}
