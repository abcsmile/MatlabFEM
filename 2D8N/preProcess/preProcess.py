# process Node and Element
with open("Job-10.inp", 'r', encoding="iso-8859-1") as fil:
    content = fil.read()
    NodeHead = "*Node"
    num_NodeHead = len(NodeHead)
    EleHead = "*Element, type=CPS8R"
    num_EleHead = len(EleHead)
    NodeInd = content.find(NodeHead)+1
    EleInd = content.find(EleHead)+1
    EleIndEnd = content.find("*Nset") - 1

    Node = content[NodeInd + num_NodeHead:EleInd - 1]
    Element = content[EleInd + num_EleHead:EleIndEnd]

    with open("Node.txt", 'w') as NodeFil:
        NodeFil.write(Node.replace(' ', ''))

    with open("Element.txt", 'w') as EleFil:
        EleFil.write(Element.replace(' ', ''))
