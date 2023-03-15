describe('product details page', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })

  it("Visits home page", () => {
    cy.visit('/')
  })
  
  it("Click on the first product", () => {
    cy.get(':nth-child(1) > a').first().click();
    cy.contains('h1', 'Scented Blade').should('be.visible');
  });

})