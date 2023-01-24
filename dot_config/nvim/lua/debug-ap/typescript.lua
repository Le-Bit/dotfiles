local M = {}

local dap = require("dap")
function M.setup()
	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = { "/home/lebit/.npm/vscode-node-debug2/out/src/nodeDebug.js" },
	}

	dap.configurations.javascript = {
		{
			name = "Launch",
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			name = "Attach to process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
	}

	dap.configurations.typescript = {
		{
			type = "node2",
			request = "launch",
			name = "Jest File Tests",
			protocol = "auto",
			program = "${workspaceFolder}/node_modules/.bin/jest",
			sourceMaps = true,
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"${workspaceFolder}/node_modules/@seccl/**",
			},
			args = { "${file}" },
			skipFiles = { "<node_internals>/**", "**/node_modules/**" },
			console = "integratedTerminal",
			internalConsoleOptions = "openOnSessionStart",
			cwd = "${workspaceFolder}/",
		},
	}
end

return M
