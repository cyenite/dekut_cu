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
import {Command} from '../models';
import {CommandRepository} from '../repositories/command.repository';

export class CommandController {

  constructor(
    @repository(CommandRepository)
    public commandRepository: CommandRepository,
  ) { }

  @post('/commands')
  @response(200, {
    description: 'Command model instance',
    content: {'application/json': {schema: getModelSchemaRef(Command)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Command, {
            title: 'NewCommand',
          }),
        },
      },
    })
    command: Command,
  ): Promise<Command> {
    return this.commandRepository.create(command);
  }

  @get('/commands/count')
  @response(200, {
    description: 'Command model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Command) where?: Where<Command>,
  ): Promise<Count> {
    return this.commandRepository.count(where);
  }

  @get('/commands')
  @response(200, {
    description: 'Array of Command model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Command, {includeRelations: true}),
        },
      },
    },
  })

  async find(
    @param.filter(Command) filter?: Filter<Command>,
  ): Promise<Command[]> {
    return this.commandRepository.find(filter);
  }

  @patch('/commands')
  @response(200, {
    description: 'Command PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Command, {partial: true}),
        },
      },
    })
    command: Command,
    @param.where(Command) where?: Where<Command>,
  ): Promise<Count> {
    return this.commandRepository.updateAll(command, where);
  }

  @get('/commands/{id}')
  @response(200, {
    description: 'Command model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Command, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Command, {exclude: 'where'}) filter?: FilterExcludingWhere<Command>
  ): Promise<Command> {
    return this.commandRepository.findById(id, filter);
  }


  @get('/commands/{deviceId}/{name}/{value}')
  @response(200, {
    description: 'Command model instance',
    content: {
      'application/json': {
        schema: {
          properties: {
            name: {type: 'string'},
            value: {type: 'string'},
          }
        },
      },
    },
  })
  async createByParam(
    @param.path.string('name') name: string,
    @param.path.string('value') value: string,
    @param.path.string('deviceId') deviceId: string,
    command: Command = new Command({name: name, value: value, deviceId: deviceId}),
    //command = new Command(),
    //command: Command,
  ): Promise<Command> {
    return this.commandRepository.create(command);
  }


  @patch('/commands/{id}')
  @response(204, {
    description: 'Command PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Command, {partial: true}),
        },
      },
    })
    command: Command,
  ): Promise<void> {
    await this.commandRepository.updateById(id, command);
  }

  @put('/commands/{id}')
  @response(204, {
    description: 'Command PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() command: Command,
  ): Promise<void> {
    await this.commandRepository.replaceById(id, command);
  }

  @del('/commands/{id}')
  @response(204, {
    description: 'Command DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.commandRepository.deleteById(id);
  }
}
