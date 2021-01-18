#Import necessary functions from Jinja2 module
from jinja2 import Environment, FileSystemLoader
import sys

#Import YAML module
import yaml

#Load data from YAML into Python dictionary
datafile = sys.argv[1]
print(datafile)

config_data = yaml.load(open(datafile))

#Load Jinja2 template
env = Environment(loader = FileSystemLoader('./provisioning/infra/templates'), trim_blocks=True, lstrip_blocks=True)
template = env.get_template('main.j2')

#Render the template with data and print the output
f= open("./provisioning/infra/generated/main.tf","w+")
f.write(template.render(config_data))
f.close()