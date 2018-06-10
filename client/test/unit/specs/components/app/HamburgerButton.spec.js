import VueTestComponentWrapper from 'vue-test-component-wrapper'

import HamburgerButton from '@/components/app/HamburgerButton'

describe('HamburgerButton', () => {
  let wrapper

  beforeEach(async () => {
    wrapper = await VueTestComponentWrapper.mounted(HamburgerButton, { expanded: false })
  })

  it('emits toggle event', async () => {
    const eventHandler = sinon.spy()
    wrapper.setCustomEventListener('toggle', eventHandler)

    await wrapper.click().untilAsyncTasksDone()

    expect(eventHandler).to.have.been.called
  })

  it('does not apply expanded styles if it is not expanded', () => {
    expect(wrapper.getClasses('.tb-hamburger-button .tb-strip:nth-child(1)')).not.to.include('tb-strip--expanded')
    expect(wrapper.getClasses('.tb-hamburger-button .tb-strip:nth-child(2)')).not.to.include('tb-strip--expanded')
    expect(wrapper.getClasses('.tb-hamburger-button .tb-strip:nth-child(3)')).not.to.include('tb-strip--expanded')
  })

  it('apply expanded styles if it is expanded', async () => {
    wrapper = await VueTestComponentWrapper.mounted(HamburgerButton, { expanded: true })

    expect(wrapper.getClasses('.tb-hamburger-button .tb-strip:nth-child(1)')).to.include('tb-strip--expanded')
    expect(wrapper.getClasses('.tb-hamburger-button .tb-strip:nth-child(2)')).to.include('tb-strip--expanded')
    expect(wrapper.getClasses('.tb-hamburger-button .tb-strip:nth-child(3)')).to.include('tb-strip--expanded')
  })
})
