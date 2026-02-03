with open("./data.mem", "w") as file:
    for i in range(16):
        file.write(f"{i * i:02x}\n")
