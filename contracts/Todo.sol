// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoEngine {
    address public immutable owner;
    struct Todo {
        string title;
        string description;
        bool completed;
    }

    Todo[] todos;

    modifier onlyOwner {
        require(msg.sender == owner, "not an owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
    
    function addTodo(string calldata _title, string calldata _description) external onlyOwner {
        todos.push(
            Todo(
                _title,
                _description,
                false
            )
        );
    }

    
    function changeTitle (string calldata _newTitle, uint index) external onlyOwner {
        todos[index].title = _newTitle;
    }

    function getTodo(uint index) external onlyOwner view returns(string memory, string memory, bool) {
         Todo memory _todo = todos[index];

         return(
            _todo.title,
            _todo.description,
            _todo.completed
         );
    }

    function changeTodoStatus(uint index) external onlyOwner {
        todos[index].completed = !todos[index].completed;
    }
}