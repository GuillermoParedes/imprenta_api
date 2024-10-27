export class Client { }
// src/users/entities/user.entity.ts
import { ApiProperty } from '@nestjs/swagger';
import { ClientRanking, ClientType, Order } from '@prisma/client';

export class ClientEntity implements Client {
  constructor(partial: Partial<ClientEntity>) {
    Object.assign(this, partial);
  }
  @ApiProperty()
  id: string;

  @ApiProperty()
  first_name: string;

  @ApiProperty()
  last_name: string;

  @ApiProperty()
  type: ClientType;

  @ApiProperty()
  address: string;

  @ApiProperty()
  cellphone: string;

  @ApiProperty()
  order?: Order[]

  @ApiProperty()
  ranking?: ClientRanking

}
