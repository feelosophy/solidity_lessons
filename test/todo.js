const { expect } = require("chai")
const { ethers } = require("hardhat")

describe("Todo", function () {
  let acc1;
  let acc2; 
  let todos;

  beforeEach(async function() {
    [acc1, acc2] = await ethers.getSigners();
    const Todo = await ethers.getContractFactory("TodoEngine", acc1);
    todo = await Todo.deploy();
    await todo.deployed();
  })

  it("should be deployed", async function() {
    expect(todo.address).to.be.properAddress;
  })

  it("should be possible to create todo", async function() {
    const title = "MyTitle"
    const description = "My description"
    const tx = await todo.addTodo(title, description);
    
    await tx.wait()

    const newTodo = await todo.getTodo(0);
    expect(newTodo[0]).to.eq(title)
    expect(newTodo[1]).to.eq(description)
    expect(newTodo[2]).to.eq(false)
  })
})