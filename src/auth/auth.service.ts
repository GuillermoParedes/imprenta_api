import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaService } from './../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import { AuthEntity } from './entity/auth.entity';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) { }

  async login(username: string, password: string): Promise<AuthEntity> {
    const user = await this.prisma.user.findFirst({ where: { username } });

    if (!user) {
      throw new NotFoundException(`Nombre de usuario no encontrado: ${username}`);
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      throw new UnauthorizedException('Contrasenia incorrecta');
    }

    return {
      accessToken: this.jwtService.sign({ userId: user.id }),
    };
  }
}
