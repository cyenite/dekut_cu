import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {FirestoreDataSource} from '../datasources';
import {Payment, PaymentRelations} from '../models/payment.model';


export class PaymentRepository extends DefaultCrudRepository<
  Payment,
  typeof Payment.prototype.id,
  PaymentRelations
> {
  constructor(
    @inject('datasources.Firestore') dataSource: FirestoreDataSource,
  ) {
    super(Payment, dataSource);
  }
}
