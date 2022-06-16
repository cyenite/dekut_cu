import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
} from '@loopback/repository';
import {
  post,
  param,
  get,
  getModelSchemaRef,
  patch,
  put,
  del,
  requestBody,
  response,
} from '@loopback/rest';
import {Device} from '../models';
import {DeviceRepository} from '../repositories';

export class DeviceController {
  constructor(
    @repository(DeviceRepository)
    public deviceRepository : DeviceRepository,
  ) {}

  @post('/devices')
  @response(200, {
    description: 'Device model instance',
    content: {'application/json': {schema: getModelSchemaRef(Device)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Device, {
            title: 'NewDevice',
            exclude: ['id'],
          }),
        },
      },
    })
    device: Omit<Device, 'id'>,
  ): Promise<Device> {
    return this.deviceRepository.create(device);
  }

  @get('/devices/count')
  @response(200, {
    description: 'Device model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Device) where?: Where<Device>,
  ): Promise<Count> {
    return this.deviceRepository.count(where);
  }

  @get('/devices')
  @response(200, {
    description: 'Array of Device model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Device, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Device) filter?: Filter<Device>,
  ): Promise<Device[]> {
    return this.deviceRepository.find(filter);
  }

  @patch('/devices')
  @response(200, {
    description: 'Device PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Device, {partial: true}),
        },
      },
    })
    device: Device,
    @param.where(Device) where?: Where<Device>,
  ): Promise<Count> {
    return this.deviceRepository.updateAll(device, where);
  }

  @get('/devices/{id}')
  @response(200, {
    description: 'Device model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Device, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Device, {exclude: 'where'}) filter?: FilterExcludingWhere<Device>
  ): Promise<Device> {
    return this.deviceRepository.findById(id, filter);
  }

  @patch('/devices/{id}')
  @response(204, {
    description: 'Device PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Device, {partial: true}),
        },
      },
    })
    device: Device,
  ): Promise<void> {
    await this.deviceRepository.updateById(id, device);
  }

  @put('/devices/{id}')
  @response(204, {
    description: 'Device PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() device: Device,
  ): Promise<void> {
    await this.deviceRepository.replaceById(id, device);
  }

  @del('/devices/{id}')
  @response(204, {
    description: 'Device DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.deviceRepository.deleteById(id);
  }
}
