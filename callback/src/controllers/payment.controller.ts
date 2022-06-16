import {
  repository
} from '@loopback/repository';
import {
  getModelSchemaRef, post, requestBody,
  response
} from '@loopback/rest';
import {Payment} from '../models';
import {PaymentRepository} from '../repositories/payment.repository';

export class PaymentController {
  constructor(
    @repository(PaymentRepository)
    public dataRepository: PaymentRepository,
  ) { }

  @post('/payment')
  @response(200, {
    description: 'Data model instance',
    content: {'application/json': {schema: getModelSchemaRef(Payment)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Payment, {
            title: 'NewData',
            exclude: ['id'],
          }),
        },
      },
    })
    data: Omit<Payment, 'id'>,
  ): Promise<Payment> {
    return this.dataRepository.create(data);
  }
}
