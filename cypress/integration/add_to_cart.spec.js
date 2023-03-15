describe('Add to Cart Feature', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })
  
  it("Visits home page", () => {
    cy.visit('/')
  })

  it("Click on the first product's Add button", () => {
    cy.get('button.btn-add-to-cart').first().click({ force: true });
    cy.contains('a', 'My Cart (1)').should('be.visible');
  });
})