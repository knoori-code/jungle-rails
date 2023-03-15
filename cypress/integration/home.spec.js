describe('home page feature test', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })
  
  it("Visits home page", () => {
    cy.visit('/')
  })

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
})