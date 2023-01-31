import { useQuery } from "react-query";
import { getCookie } from "react-use-cookie";

const authToken = getCookie("authtoken");

export const fetchEmployees = async (department) => {
  const response = await fetch(
    `http://localhost:3000/employees?department=${department}`
  );
  return response.json();
};

const fetchEmployee = async (id) => {
  const response = await fetch(`http://localhost:3000/employees/${id}`);
  return response.json();
};

const fetchDepartments = async () => {
  const response = await fetch("http://localhost:3000/departments");
  return response.json();
};

export const getEmployeesByDepartment = (queryId, department) => {
  return useQuery(queryId, async () => await fetchEmployees(department));
};

export const getDepartments = (queryId) => {
  return useQuery(queryId, async () => await fetchDepartments());
};

export const getEmployee = (queryId, id) => {
  return useQuery([queryId, id], async () => await fetchEmployee(id), {
    enabled: !!id,
  });
};

export const postLoginData = async (user) => {
  const response = await fetch("http://localhost:3000/auth", {
    method: "POST",
    body: JSON.stringify({
      user_name: user.user_name,
      password: user.password,
    }),
    headers: { "Content-Type": "application/json" },
  });
  return response.json();
};

const employeeAttributes = (employee) => {
  return JSON.stringify({
    full_name: employee.full_name,
    email: employee.email,
    department_id: employee.department_id,
  });
};

export const updateEmployeeData = async (employee) => {
  const employeeData = employeeAttributes(employee);
  const response = await fetch(
    `http://localhost:3000/employees/${employee.id}`,
    {
      method: "PATCH",
      body: employeeData,
      headers: {
        "Content-Type": "application/json",
        Authorization: `${authToken}`,
      },
    }
  );
  return response.json();
};

export const createEmployeeData = async (employee) => {
  const employeeData = employeeAttributes(employee);
  const response = await fetch(`http://localhost:3000/employees/`, {
    method: "POST",
    body: employeeData,
    headers: {
      "Content-Type": "application/json",
      Authorization: `${authToken}`,
    },
  });
  return response.json();
};

export const deleteEmployeeData = async (employeeId) => {
  const response = await fetch(
    `http://localhost:3000/employees/${employeeId}`,
    {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        Authorization: `${authToken}`,
      },
    }
  );
  return response.json();
};
