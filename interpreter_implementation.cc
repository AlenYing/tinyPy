#include "implementation.hh"
#include <iostream>
#include <sstream>

std::map<std::string, unsigned> value_table;
std::map<std::string, std::string> string_table;

unsigned number_expression::get_value() const {
    return value;
}

std::string number_expression::get_string() const {
    return std::to_string(value);
}

unsigned boolean_expression::get_value() const {
    return (unsigned)value;
}

std::string boolean_expression::get_string() const {
    if(value == 1) return "false";
    else if (value == 0) return "true";
}

unsigned string_expression::get_value() const {
    return -1;
}

std::string string_expression::get_string() const {
    return strExp;
}

unsigned id_expression::get_value() const {
    if(value_table.count(name) == 0) {
        error(line, std::string("Variable has not been initialized: ") + name);
    }
    return value_table[name];
}

std::string id_expression::get_string() const {
    return string_table[name];
}

unsigned binop_expression::get_value() const {
    int left_value = left->get_value();
    int right_value = right->get_value();
    if(op == "+") {
        return left_value + right_value;
    } else if(op == "-") {
        return left_value - right_value;
    } else if(op == "*") {
        return left_value * right_value;
    } else if(op == "/") {
        return left_value / right_value;
    } else if(op == "%") {
        return left_value % right_value;
    } else if(op == "<") {
        return left_value < right_value;
    } else if(op == ">") {
        return left_value > right_value;
    } else if(op == "<=") {
        return left_value <= right_value;
    } else if(op == ">=") {
        return left_value >= right_value;
    } else if(op == "and") {
        return left_value && right_value;
    } else if(op == "or") {
        return left_value || right_value;
    } else if(op == "=") {
        return left_value == right_value;
    } else {
        error(line, std::string("Unknown operator: ") + op);
    }
}

std::string binop_expression::get_string() const {
    int left_value = left->get_value();
    int right_value = right->get_value();
    if(op == "+") {
        return std::to_string(left_value + right_value);
    } else if(op == "-") {
        return std::to_string(left_value - right_value);
    } else if(op == "*") {
        return std::to_string(left_value * right_value);
    } else if(op == "/") {
        return std::to_string(left_value / right_value);
    } else if(op == "%") {
        return std::to_string(left_value % right_value);
    } else if(op == "<") {
        return std::to_string(left_value < right_value);
    } else if(op == ">") {
        return std::to_string(left_value > right_value);
    } else if(op == "<=") {
        return std::to_string(left_value <= right_value);
    } else if(op == ">=") {
        return std::to_string(left_value >= right_value);
    } else if(op == "and") {
        return std::to_string(left_value && right_value);
    } else if(op == "or") {
        return std::to_string(left_value || right_value);
    } else if(op == "=") {
        return std::to_string(left_value == right_value);
    } else {
        error(line, std::string("Unknown operator: ") + op);
    }
}

unsigned not_expression::get_value() const {
    return !(bool)(operand->get_value());
}

std::string not_expression::get_string() const {
    if(operand->get_value() == 1) return "false";
    else if (operand->get_value() == 0) return "true";
    else return "nop";
}

void assign_instruction::execute() {
    if (right->get_type() == natural) {
        value_table[left] = right->get_value();
    } else if (right->get_type() == boolean) {
        value_table[left] = right->get_value();
    } else if (right->get_type() == py_string) {
        string_table[left] = right->get_string();
    }
}

void read_instruction::execute() {
    std::string input_line;
    getline(std::cin, input_line);
    if(symbol_table[id].symbol_type == natural) {
        std::stringstream ss(input_line);
        unsigned input;
        ss >> input;
        value_table[id] = input;
    } else if(symbol_table[id].symbol_type == boolean) {
        if(input_line == "true") {
            value_table[id] = 1;
        } else {
            value_table[id] = 0;
        }
    } 
}

void write_instruction::execute() {
    if(exp_type == natural) {
        std::cout << exp->get_value() << std::endl;
    } else if(exp_type == boolean) {
        if(exp->get_value()) {
            std::cout << "true" << std::endl;
        } else {
            std::cout << "false" << std::endl;
        }
    } else if(exp_type == py_string) {
        std::cout << exp->get_string() << std::endl;
    }
}

void if_instruction::execute() {
    if(condition->get_value()) {
        execute_commands(true_branch);
    } else {
        execute_commands(false_branch);
    }
}

void while_instruction::execute() {
    std::list<instruction*>::iterator it;
    while(condition->get_value()) {
        execute_commands(body);
    }
}

void execute_commands(std::list<instruction*>* commands) {
    if(!commands) {
        return;
    }

    std::list<instruction*>::iterator it;
    for(it = commands->begin(); it != commands->end(); ++it) {
        (*it)->execute();
    }
}
