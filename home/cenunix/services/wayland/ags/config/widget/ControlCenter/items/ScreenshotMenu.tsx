import { Gtk } from "astal/gtk3";
import { Variable } from "astal";
import icons from "../../../lib/icons";
import { spacing } from "../../../lib/variables";
import { bash, toggleWindow } from "../../../lib/utils";
import { Menu } from "../pages/Main";
import { namespace } from "..";

export const revealScreenShot = Variable(false);

export default ({
	revealMenu,
	closeMenu,
}: {
	revealMenu: Variable<boolean>;
	closeMenu: () => void;
}) => {
	const content = (
		<box
			vertical
			className={"control-center__dropdown-menu sink-box qs-menu"}
			spacing={spacing * 2}
		>
			<label
				label={"Screenshot Menu"}
				className={"control-center__dropdown-menu_title"}
			/>
			
			<button
				className={"cotrol-center-menu-button"}
				onClicked={() => {
					closeMenu
					toggleWindow(namespace)
					bash('screenshot')
				}}
			>
				<box
					hexpand
					className={"control-center__dropdown-menu_item"}
					spacing={spacing * 2}
				>
					<icon icon={icons.screenshot} halign={Gtk.Align.CENTER} />
					<label label={"Full display"} />
				</box>
			</button>

			<button
				className={"cotrol-center-menu-button"}
				onClicked={() => {
					closeMenu
					toggleWindow(namespace)
					bash('screenshot 1')
				}}
			>
				<box
					hexpand
					className={"control-center__dropdown-menu_item"}
					spacing={spacing * 2}
				>
					<icon icon={icons.select} halign={Gtk.Align.CENTER} />
					<label label={"Select region"} />
				</box>
			</button>

			<button
				className={"cotrol-center-menu-button"}
				onClicked={() => {
					closeMenu
					toggleWindow(namespace)
					bash('screenshot 2')
				}}
			>
				<box
					hexpand
					className={"control-center__dropdown-menu_item"}
					spacing={spacing * 2}
				>
					<icon icon={icons.window} halign={Gtk.Align.CENTER} />
					<label label={"Select window"} />
				</box>
			</button>
		</box>
	);

	return (<Menu name={"screenshot"} bindVariable={revealMenu} content={[content]}/>);
};
