import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class CreatorCheckService {
  constructor(private readonly db: PrismaService) {}

  async creatorCheck(user_wallet_address: string): Promise<boolean> {
    const result = await this.db.creator.findUnique({
      where: { creator_id: user_wallet_address },
    });
    if (result.is_creator) {
      return true;
    } else return false;
  }
}
