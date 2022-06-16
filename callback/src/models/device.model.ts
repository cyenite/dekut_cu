import {Entity, model, property} from '@loopback/repository';

@model()
export class Device extends Entity {
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
  commandId: string;

  @property({
    type: 'string',
    required: true,
  })
  macAddress: string;

  @property({
    type: 'string',
  })
  status?: string;


  constructor(data?: Partial<Device>) {
    super(data);
  }
}

export interface DeviceRelations {
  // describe navigational properties here
}

export type DeviceWithRelations = Device & DeviceRelations;
