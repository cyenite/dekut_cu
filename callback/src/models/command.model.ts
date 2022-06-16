import {Entity, model, property} from '@loopback/repository';

@model()
export class Command extends Entity {
  @property({
    type: 'string',
    required: true,
  })
  name: string;

  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'string',
    required: true,
  })
  value: string;

  @property({
    type: 'string',
    required: true,
  })
  deviceId: string;

  constructor(data?: Partial<Command>) {
    super(data);
  }
}

export interface CommandRelations {
  // describe navigational properties here
}

export type CommandWithRelations = Command & CommandRelations;
