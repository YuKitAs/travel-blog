import VueTestComponentWrapper from 'vue-test-component-wrapper'

import NavItemList from '@/components/app/NavItemList'

describe('NavItemList', () => {
  let wrapper

  beforeEach(async () => {
    wrapper = await VueTestComponentWrapper.mounted(NavItemList)
  })

  it('displays all the navigation items', () => {
    expect(wrapper.getTextContents('span.tb-item')).to.include('Articles', 'Tags', 'About')
  })
})
