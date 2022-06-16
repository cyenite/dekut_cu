import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where
} from '@loopback/repository';
import {
  del, get,
  getModelSchemaRef, param, patch, post, put, requestBody,
  response
} from '@loopback/rest';
import {Data} from '../models/data.model';
import {DataRepository} from '../repositories/data.repository';

export class DataController {
  constructor(
    @repository(DataRepository)
    public dataRepository: DataRepository,
  ) { }

  @post('/data')
  @response(200, {
    description: 'Data model instance',
    content: {'application/json': {schema: getModelSchemaRef(Data)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Data, {
            title: 'NewData',
            exclude: ['id'],
          }),
        },
      },
    })
    data: Omit<Data, 'id'>,
  ): Promise<Data> {
    return this.dataRepository.create(data);
  }

  @get('/data/count')
  @response(200, {
    description: 'Data model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Data) where?: Where<Data>,
  ): Promise<Count> {
    return this.dataRepository.count(where);
  }

  @get('/data')
  @response(200, {
    description: 'Array of Data model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Data, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Data) filter?: Filter<Data>,
  ): Promise<Data[]> {
    return this.dataRepository.find(filter);
  }

  @patch('/data')
  @response(200, {
    description: 'Data PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Data, {partial: true}),
        },
      },
    })
    data: Data,
    @param.where(Data) where?: Where<Data>,
  ): Promise<Count> {
    return this.dataRepository.updateAll(data, where);
  }

  @get('/data/{id}')
  @response(200, {
    description: 'Data model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Data, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Data, {exclude: 'where'}) filter?: FilterExcludingWhere<Data>
  ): Promise<Data> {
    return this.dataRepository.findById(id, filter);
  }

  @get('/data/{deviceId}/{name}/{value}')
  @response(200, {
    description: 'Data model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Data, {includeRelations: true}),
      },
    },
  })
  async addDataUsingParams(
    @param.path.string('name') name: string,
    @param.path.string('value') value: string,
    @param.path.string('deviceId') deviceId: string,
    data: Data = new Data({name: name, value: value, deviceId: deviceId}),
  ): Promise<Data> {
    return this.dataRepository.create(data);
  }

  @patch('/data/{id}')
  @response(204, {
    description: 'Data PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Data, {partial: true}),
        },
      },
    })
    data: Data,
  ): Promise<void> {
    await this.dataRepository.updateById(id, data);
  }

  @put('/data/{id}')
  @response(204, {
    description: 'Data PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() data: Data,
  ): Promise<void> {
    await this.dataRepository.replaceById(id, data);
  }

  @del('/data/{id}')
  @response(204, {
    description: 'Data DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.dataRepository.deleteById(id);
  }
}
