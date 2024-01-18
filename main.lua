local v1, v2 = arg[2 - 1], arg[5 - 3];
local v3;
do 
	local v6 = io.popen('dir "' .. v1 .. '" /b');
	local function v7(v33)
		return (v33 == "semachkamakefile") or 
               (v33 == "semakefile") or 
               (v33 == "semachkamake") or 
               (v33 == "semake");
	end
	for v34 in v6:lines() do
		if v7(v34:lower()) then
			v3 = v34;
			break;
		end
	end
	v6:close();
	if not v3 then
		error("semake: make file not found");
	end
end
do
	env = {};
	pointers = {};
end
do
	string.replace = function(v35, v36, v37)
		local v38 = "";
		local v39 = 1 - 0;
		local v40;
		while true do
			local v67 = "";
			for v90 = v39, #v35 do
				v67 = v35:sub(v39, v90);
				if (v67 == v36) then
					v40 = v90;
					break;
				end
			end
			if v40 then
				break;
			end
			v39 = v39 + (2 - 1);
			if (v39 > #v35) then
				error("pointer overflow");
			end
		end
		v38 = v35:sub(620 - (555 + 64), v39 - (932 - (857 + 74))) .. v37 .. v35:sub(v40 + (569 - (367 + 201)), -(928 - (214 + 713)));
		return v38;
	end;
end
local v4 = {["\115"]=function(v9, v10, v11)
	env[v10] = v11;
	return v11;
end,["\118"]=function(v13, v14)
	return env[v14] or "";
end,["\105"]=function(v15, ...)
	local v16 = {...};
	for v41, v42 in next, v16 do
		if (v42 == "") then
			table.remove(v16, v41);
		end
	end
	local v17 = setmetatable({need=v16,comms={add=table.insert}}, {__concat=function(...)
		return (...);
	end});
	return v17;
end,["\112"]=function(v18, v19)
	pointers[v19] = v18;
	local v21 = setmetatable({comms={add=table.insert}}, {__concat=function(...)
		return (...);
	end});
	return v21;
end};
local v5 = {add=table.insert};
do
	local v22 = 0
	local function v23(v43, v44)
		local v45 = {add = table.insert, start = 0};
		local v46 = v45;
		local v47 = 0
		local function v48(v68)
			if v43:sub(v68, v68):match("%s") then
				return;
			end
			for v91 = v68 + 1 + 0, #v43 do
				local v92 = v43:sub(v91, v91);
				if (v92 == "\40") then
					return v91;
				elseif v92:match("%S") then
					return;
				end
			end
		end
		local function v49()
			if not v46.args then
				error("semake: invalid syntax at line " .. v44);
			end
		end
		local function v50(v69)
			local v70 = "";
			local v71;
			for v93 = 1 - 0, #v69 do
				local v94 = v69:sub(v93, v93);
				if v94:match("%S") then
					v71 = true;
				end
				if v71 then
					v70 = v70 .. v94;
				end
			end
			v71 = false;
			for v95 = #v70, 1066 - (68 + 997), -(1271 - (226 + 1044)) do
				local v96 = v70:sub(v95, v95);
				if v96:match("%S") then
					v71 = true;
				end
				if not v71 then
					v70 = v70:sub(4 - 3, v95 - (118 - (32 + 85)));
				end
			end
			return v70;
		end
		local function v51(v72)
			local v73 = "";
			v73 = v73 .. v72.code .. v72.space .. "\40";
			for v97, v98 in next, v72.args do
				v73 = v73 .. v98 .. "\44";
			end
			v73 = v73:sub(1 + 0, -(1 + 1)) .. "\41";
			return v73;
		end
		local function v52(v74)
			v22 = v22 + (958 - (892 + 65));
			for v99, v100 in next, v74.args do
				local v101 = v23(v100, v44);
				if (#v101 > (0 - 0)) then
					for v128, v129 in next, v101 do
						if (type(v129) == "table") then
							v52(v129, v44);
							if v129.result then
								v74.args[v99] = v74.args[v99]:replace(v129.source, v129.result);
							end
						end
					end
				end
			end
			local v75 = v4[v74.code:lower()];
			if not v75 then
				error("semake: attempt to call unknown functon at line " .. v44);
			end
			for v102, v103 in next, v74.args do
				v74.args[v102] = v50(v103);
			end
			v74.result = v75(v74, table.unpack(v74.args));
			v22 = v22 - (1 - 0);
		end
		for v77 = 1, #v43 do
			local v78 = v43:sub(v77, v77);
			local v79 = (v47 == (350 - (87 + 263))) and v48(v77);
			if v79 then
				local v116 = {code=v78,start=v79,space=v43:sub(v77 + (181 - (67 + 113)), v79 - (1 + 0)),stack=v47,args={"",add=table.insert}};
				v45:add(v116);
				v46 = v116;
			else
				local function v117()
					if not v46.args then
						return;
					end
					local v124 = v46.args;
					local v125 = #v124;
					v124[v125] = v124[v125] .. v78;
				end
				if (v78 == "\40") then
					if (v47 > (0 + 0)) then
						v117();
					end
					v47 = v47 + (3 - 2);
				elseif (v78 == "\41") then
					v47 = v47 - (953 - (802 + 150));
					if (v47 > (0 - 0)) then
						v117();
					end
					if (v47 == (0 - 0)) then
						v46.args.add = nil;
						v46.finish = v77;
						v46.source = v51(v46);
						if (v22 == (0 + 0)) then
							v52(v46);
						end
						v46 = v45;
					end
				elseif (v78 == "\44") then
					v49();
					v46.args:add("");
				elseif (v77 > v46.start) then
					if (v47 > (997 - (915 + 82))) then
						v49();
					end
					v117();
				end
				if (v47 < (0 - 0)) then
					error("semake: invalid syntax at line " .. v44);
				end
			end
		end
		v45.add = nil;
		v45.start = nil;
		if v22 == 0 then
			v45.result = v43;
			for v118, v119 in next, v45 do
				if (v119 ~= v45.result) then
					v45.result = v45.result:replace(v119.source, v119.result);
				end
			end
		end
		return v45;
	end
	local v24;
	local v25 = io.input(v1 .. "\\" .. v3);
	local v26 = {};
	for v55 in v25:lines() do
		table.insert(v26, v55);
	end
	v25:seek("end", -v25:seek());
	local function v27(...)
		local v56 = v25:lines(...);
		return function(...)
			local v80 = v56(...);
			local v81;
			for v106, v107 in next, v26 do
				if (v107 == v80) then
					v81 = v106;
					break;
				end
			end
			return v80, v81;
		end;
	end
	local function v28()
		return (v24 and (v24.code:lower() == "\105")) or (v24 and (v24.code:lower() == "\112"));
	end
	for v57, v58 in v27() do
		local v59 = v28();
		if v59 then
			local v108 = v57:sub(1, 2)
			if v108:match'^(%s+)(%S?)' then
				local v127 = v23(v57, v58);
				v24.result.comms:add(v127.result);
			elseif v108:match'^#(%s)' then
				v24.result.comms:add(v57:sub(2, -1))
			else
				v24 = nil;
			end
		end
		if not v59 then
			local v109 = v23(v57, v58);
			v109.line = v58;
			v5:add(v109);
			v24 = v109[#v109];
		end
	end
	v25:close();
end
do
	local v29 = {add=table.insert};
	local function v30(v60)
		v60.comms.add = nil;
		for v82, v83 in next, v60.comms do
			os.execute("cd " .. v1 .. " & " .. v83);
		end
	end
	local function v31(v62)
		local v63 = true;
		for v84, v85 in next, v62.result.need do
			local v86<close> = io.open(v1 .. "\\" .. v85, "r");
			if (v86 == nil) then
				v63 = false;
				break;
			end
		end
		return v63;
	end
	local function v32(v64, v65)
		local v66 = v31(v64);
		if v66 then
			if v65 then
				table.remove(v29, v65);
			end
			v30(v64.result);
			for v120, v121 in next, v29 do
				if (v120 ~= "add") then
					v32(v121, v120);
				end
			end
		else
			v29:add(v64);
		end
	end
	if v2 then
		v2 = pointers[v2];
		if not v2 then
			error("semake: attempt to call unknown pointer");
		end
		v30(v2.result);
	else
		v5.add = nil;
		for v112, v113 in next, v5 do
			for v122, v123 in next, v113 do
				if ((type(v123) == "table") and (v123.code:lower() == "\105")) then
					v123.line = v113.line;
					v32(v123);
				end
			end
		end
		v29.add = nil;
		for v114, v115 in next, v29 do
			print("semake: instruction at line " .. v115.line .. " didnt wait for all components of build.");
		end
	end
end
