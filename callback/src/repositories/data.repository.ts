import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {FirestoreDataSource} from '../datasources';
import {Data, DataRelations} from '../models/data.model';


export class DataRepository extends DefaultCrudRepository<
  Data,
  typeof Data.prototype.id,
  DataRelations
> {
  constructor(
    @inject('datasources.Firestore') dataSource: FirestoreDataSource,
  ) {
    super(Data, dataSource);
  }
}
