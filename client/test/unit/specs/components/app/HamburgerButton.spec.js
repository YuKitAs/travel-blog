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

    await wrapper.click().untilPromisesResolved()

    expect(eventHandler).to.have.been.called
  })
})
