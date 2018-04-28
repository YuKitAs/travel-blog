import Navbar from '@/components/app/Navbar'
import NavbarSelectors from '@test/selector/components/app/Navbar'
import VueTestComponentWrapper from 'vue-test-component-wrapper'

describe('Navbar', () => {
  let wrapper

  beforeEach(async () => {
    wrapper = await VueTestComponentWrapper.mounted(Navbar)
  })

  it('shows correct nav item text', () => {
    expect(wrapper.getTextContents(NavbarSelectors.navItems)).to.eql(['Articles', 'Places', 'Timeline', 'About'])
  })

  it('redirects to the correct page', async () => {
    wrapper.setRouterStub()
    await wrapper.click(NavbarSelectors.firstNavItem).untilAsyncTasksDone()

    expect(wrapper.getRouterStub()).to.calledWith({name: 'Articles'})
  })
})
