def accounts_read(type: str ,numbers: int,path: str) -> list:
    """
    Args:
        type (str): Either "account", "password" or "both"
        numbers (int): How many Account should be read
        path (str): Path to file
    Returns:
        List of len numbers containg account data or and list containg password data
    Example:
        "both", 2 -> (['manwevalar1379@duck.com', 'glorfindel1892@duck.com'], ['1Ringtorulethemall', '1Ringtorulethemall'])

    """
    if type not in ["password","account", "both", "icloudmail"]:
        return "unsupported type"
    
    account_list = []
    password_list = []
    

    file = open(path,"r")
    for counter, line in enumerate(file, start=1):
        if counter > int(numbers):
            break
        else:
            line_content = eval(line)
            if type == "both":
                account_list.append(line_content.get("account"))
                password_list.append(line_content.get("password"))   

            elif type == "account":
                account_list.append(line_content.get(type))
            elif type == "icloudmail":
                account_list.append(line_content.get(type))

            else:
                password_list.append(line_content.get(type))                         
    file.close()
    if type == "both":         
        return account_list, password_list
    elif type == "account" or type == "icloudmail":
        return account_list
    else:
        return password_list



