import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {FirestoreDataSource} from '../datasources';
import {Device, DeviceRelations} from '../models';

export class DeviceRepository extends DefaultCrudRepository<
  Device,
  typeof Device.prototype.id,
  DeviceRelations
> {
  constructor(
    @inject('datasources.Firestore') dataSource: FirestoreDataSource,
  ) {
    super(Device, dataSource);
  }
}
