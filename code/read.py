
def accounts_read(type: str, start: int, end: int, path: str) -> list | tuple[list, list] | str:
    """
    Reads account or password data from a file within a specified range.

    Args:
        type (str): Either "account", "password", "both", or "icloudmail".
        start (int): The starting line number (1-based).
        end (int): The ending line number (inclusive, 1-based).
        path (str): Path to the file.

    Returns:
        list | tuple[list, list]: Depending on the type:
            - "account" or "icloudmail": List of accounts.
            - "password": List of passwords.
            - "both": Tuple containing two lists ([accounts], [passwords]).
            - "unsupported type": If the type is invalid.

    Example:
        For type="both", start=2, end=3, and a file containing:
            {"account": "user1@example.com", "password": "pass1"}
            {"account": "user2@example.com", "password": "pass2"}
            {"account": "user3@example.com", "password": "pass3"}
        Output:
            (["user2@example.com", "user3@example.com"], ["pass2", "pass3"])
    """
    if type not in ["password", "account", "both", "icloudmail"]:
        return "unsupported type"

    if start < 1 or end < start:
        return "Invalid range."

    account_list = []
    password_list = []

    try:
        with open(path, "r") as file:
            for counter, line in enumerate(file, start=1):
                if counter < start:
                    continue  # Skip lines before the start
                if counter > end:
                    break  # Stop reading after the end
                
                try:
                    # Directly evaluate the line content as a Python dictionary
                    line_content = eval(line.strip())
                except (SyntaxError, ValueError):
                    continue  # Skip invalid lines
                
                if type == "both":
                    account_list.append(line_content.get("account"))
                    password_list.append(line_content.get("password"))
                elif type in ["account", "icloudmail"]:
                    account_list.append(line_content.get(type))
                else:  # type == "password"
                    password_list.append(line_content.get("password"))

    except FileNotFoundError:
        return "File not found."
    except Exception as e:
        return f"An error occurred: {str(e)}"

    if type == "both":
        return account_list, password_list
    elif type in ["account", "icloudmail"]:
        return account_list
    else:
        return password_list



