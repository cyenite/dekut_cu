import {Entity, model, property} from '@loopback/repository';

@model()
export class Payment extends Entity {
  @property({
    type: 'string',
    required: true,
  })
  MerchantRequestID: string;

  @property({
    type: 'string',
    required: true,
  })
  CheckoutRequestID: string;

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
  ResultCode: string;

  @property({
    type: 'string',
    required: true,
  })
  ResultDesc: string;

  // @property({
  //   type: 'array',
  //   required: true,
  // })
  // CallbackMetadata: Array<Item>;

  constructor(data?: Partial<Payment>) {
    super(data);
  }
}

export interface PaymentRelations {
  // describe navigational properties here
}

export type DataWithRelations = Payment & PaymentRelations;


@model()
export class Item extends Entity {
  @property({
    type: 'string',
    required: true,
  })
  Name: string;

  @property({
    type: 'string',
    required: true,
  })
  Value: string;

  constructor(data?: Partial<Payment>) {
    super(data);
  }
}
