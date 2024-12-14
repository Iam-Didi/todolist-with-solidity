// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TodoList {
    struct TodoItem {
        string task;
        bool isCompleted;
    }

    mapping (uint256 => TodoItem) public list;
    uint256 public count = 0;
    address public owner;

    event TaskCompleted(uint256 indexed id);

    constructor() {
        owner = msg.sender;
    }

    function addTask(string calldata task) onlyowner public {
        TodoItem memory item = TodoItem({task: task, isCompleted: false});
        list[count] = item;
        count++;
    }

    function completeTask(uint256 id) onlyowner public {
        if (list[id].isCompleted) {
            list[id].isCompleted = true;
            emit TaskCompleted(id);
        }
    }

    modifier onlyowner() {
        require(owner == msg.sender, "only owner can call this");
        _;
    }
}