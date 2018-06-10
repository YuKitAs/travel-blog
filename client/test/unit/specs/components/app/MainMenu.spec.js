import VueTestComponentWrapper from 'vue-test-component-wrapper'

import MainMenu from '@/components/app/MainMenu'
import Responsive from '@/services/Responsive'

describe('MainMenu', () => {
  let wrapper
  let responsiveStub

  beforeEach(async () => {
    responsiveStub = sinon.stub(Responsive, 'MEDIUM_AND_UP').get(() => false)
    wrapper = await VueTestComponentWrapper.mounted(MainMenu)
  })

  afterEach(async () => {
    responsiveStub.restore()
  })

  it('loads with its sub-components', () => {
    expect(wrapper.hasElement('.tb-hamburger-button')).to.equal(true)
    expect(wrapper.hasElement('.tb-nav-item-list')).to.equal(true)
  })

  it('hides menu after loaded', () => {
    // This assumes in the unit test, this.$refs['main-menu'].offsetHeight is 0
    expect(wrapper.getStyleProperty(null, 'margin-top')).to.equal('55px')
    expect(wrapper.getWrappedChild('.tb-hamburger-button').getProp('expanded')).to.equal(false)
  })

  it('reacts on toggle event from hamburger button component', async () => {
    await wrapper.getWrappedChild('.tb-hamburger-button').triggerCustomEvent('toggle').untilAsyncTasksDone()

    expect(wrapper.getStyleProperty(null, 'margin-top')).to.equal('0px')
    expect(wrapper.getWrappedChild('.tb-hamburger-button').getProp('expanded')).to.equal(true)
  })
})
