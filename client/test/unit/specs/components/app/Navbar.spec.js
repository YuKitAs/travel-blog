import Navbar from '@/components/app/Navbar';
import NavbarSelectors from '../../../../selector/components/app/Navbar';
import VueComponentWrapper from 'vue-component-wrapper';

describe('Navbar', () => {
  let wrapper;

  beforeEach(async () => {
    wrapper = await VueComponentWrapper.mounted(Navbar);
  });

  it('shows correct nav item text', () => {
    expect(wrapper.getTextContents(NavbarSelectors.navItems)).to.eql(['Articles', 'Places', 'Timeline', 'About']);
  });
});
