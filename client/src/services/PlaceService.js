import CrudHttpClient from '@/services/CrudHttpClient';

class PlaceService extends CrudHttpClient {
  constructor() {
    super('places');
  }
}

export default new PlaceService();
