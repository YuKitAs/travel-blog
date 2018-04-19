import PlaceService from '@/services/PlaceService';

describe('PlaceService', () => {
  it('builds correct url with its resource name', () => {
    expect(PlaceService.buildUrl()).to.equal('api/places');
    expect(PlaceService.buildUrl('place-id')).to.equal('api/places/place-id');
  });
});
